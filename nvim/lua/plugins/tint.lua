return {
  "levouh/tint.nvim",
  config = function()
    local tint = require("tint")

    tint.setup({
      tint = -45,  -- Darken colors, use a positive value to brighten
      saturation = 0.6,  -- Saturation to preserve
      transforms = require("tint").transforms.SATURATE_TINT,  -- Showing default behavior, but value here can be predefined set of transforms
      tint_background_colors = true,  -- Tint background portions of highlight groups
      highlight_ignore_patterns = { "WinSeparator", "Status.*" },  -- Highlight group patterns to ignore, see `string.find`
    })
  end
}
