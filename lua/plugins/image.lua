local default_width_percentage = 95
local default_height_percentage = 90
local resize_step = 10
local minimum_scale = 10
local maximum_scale = 150

local function sync_standalone_scroll_area(preview)
  local buffer = preview.buffer

  if not buffer or not vim.api.nvim_buf_is_valid(buffer) or vim.bo[buffer].filetype ~= "image_nvim" then
    return
  end

  local height = preview.rendered_geometry and preview.rendered_geometry.height
  if not height or height < 1 then
    return
  end

  height = math.max(1, math.ceil(height))
  preview.overlap = height

  if vim.api.nvim_buf_line_count(buffer) ~= height then
    local lines = {}
    for _ = 1, height do
      lines[#lines + 1] = ""
    end

    vim.bo[buffer].modifiable = true
    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)
    vim.bo[buffer].modifiable = false
    vim.bo[buffer].modified = false
  end
end

local function enable_standalone_scrolling(preview)
  if preview._standalone_scrolling_enabled then
    return
  end

  preview._standalone_scrolling_enabled = true

  if preview.window and vim.api.nvim_win_is_valid(preview.window) then
    vim.api.nvim_win_call(preview.window, function()
      vim.opt_local.fillchars:append({ eob = " " })
      vim.opt_local.list = false
      vim.opt_local.wrap = false
    end)
  end

  local original_render = preview.render

  preview.render = function(self, geometry)
    local result = original_render(self, geometry)
    vim.schedule(function()
      sync_standalone_scroll_area(self)
    end)
    return result
  end

  preview:render()
end

local function set_preview_scale(scale)
  local image = require("image")
  local buffer = vim.api.nvim_get_current_buf()
  local window = vim.api.nvim_get_current_win()
  local images = image.get_images({ buffer = buffer, window = window })

  if #images == 0 then
    vim.notify("No image preview in the current window", vim.log.levels.WARN)
    return
  end

  scale = math.max(minimum_scale, math.min(maximum_scale, scale))
  vim.b[buffer].image_preview_scale = scale

  local width_percentage = math.max(1, math.floor(default_width_percentage * scale / 100))
  local height_percentage = math.max(1, math.floor(default_height_percentage * scale / 100))

  for _, current_image in ipairs(images) do
    current_image.max_width_window_percentage = width_percentage
    current_image.max_height_window_percentage = height_percentage
    current_image:clear(true)
    current_image:render()
  end

  vim.notify(("Image preview size: %d%%"):format(scale))
end

local function resize_preview(delta)
  local current_scale = vim.b.image_preview_scale or 100
  set_preview_scale(current_scale + delta)
end

return {
  "3rd/image.nvim",
  lazy = false,
  build = false,
  keys = {
    {
      "<leader>i+",
      function()
        resize_preview(resize_step)
      end,
      desc = "Increase image preview size",
    },
    {
      "<leader>i-",
      function()
        resize_preview(-resize_step)
      end,
      desc = "Decrease image preview size",
    },
    {
      "<leader>i=",
      function()
        set_preview_scale(100)
      end,
      desc = "Reset image preview size",
    },
  },
  opts = {
    backend = "kitty",
    processor = "magick_cli",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" },
      },
    },
    max_width = nil,
    max_height = nil,
    -- Use almost the entire editor window for standalone image previews.
    max_width_window_percentage = default_width_percentage,
    max_height_window_percentage = default_height_percentage,
    window_overlap_clear_enabled = false,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  },
  config = function(_, opts)
    local image = require("image")
    image.setup(opts)

    local original_hijack_buffer = image.hijack_buffer
    image.hijack_buffer = function(path, window, buffer, options)
      local preview = original_hijack_buffer(path, window, buffer, options)
      if preview then
        enable_standalone_scrolling(preview)
      end
      return preview
    end
  end,
}
