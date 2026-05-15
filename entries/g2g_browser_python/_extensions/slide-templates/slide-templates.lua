-- slide-templates.lua — shortcodes for recurring slide patterns
--
-- Registered via _extension.yml contributes.shortcodes.
-- Each top-level function name becomes {{< name ... >}}.

-- Quarto populates kwargs with empty Inlines for unprovided keys (not nil).
-- Must check for empty string after stringify to correctly apply defaults.
-- GoodTurn: https://goodturn.ai/p/gtp_01krchvxmqe6xr69b5dkfjb73s
local function kwarg(kwargs, key, default)
  local v = kwargs[key]
  if v == nil then return default end
  local s = pandoc.utils.stringify(v)
  if s == "" then return default end
  return s
end

local function pos_arg(args, idx, default)
  if args[idx] == nil then return default end
  return pandoc.utils.stringify(args[idx])
end


-- {{< section num="01" title="The WHY" subtitle="..." part="One" of="Four" warm="true" >}}
--
-- Renders the full section-divider slide interior:
--   eyebrow (if part given) + big-dither numeral + section-divider heading/subtitle.
function section(args, kwargs)
  local num      = kwarg(kwargs, "num", "")
  local title    = kwarg(kwargs, "title", "")
  local subtitle = kwarg(kwargs, "subtitle", nil)
  local part     = kwarg(kwargs, "part", nil)
  local of       = kwarg(kwargs, "of", "Four")
  local warm     = kwarg(kwargs, "warm", nil)
  local parts = {}

  -- Eyebrow: "Part One · of Four"
  if part then
    table.insert(parts,
      '<div class="eyebrow">Part ' .. part ..
      ' <span class="sep">&middot;</span> of ' .. of .. '</div>')
  end

  -- Big dither numeral
  local dither_class = "big-dither"
  if warm == "true" then dither_class = "big-dither warm" end
  table.insert(parts,
    '<div class="' .. dither_class .. '">' .. num .. '</div>')

  -- Section divider block
  local divider = '<div class="section-divider">\n<h3>' .. title .. '</h3>'
  if subtitle then
    divider = divider .. '\n<p>' .. subtitle .. '</p>'
  end
  divider = divider .. '\n</div>'
  table.insert(parts, divider)

  return pandoc.RawBlock('html', table.concat(parts, '\n\n'))
end


-- {{< eyebrow "§1 WHY" >}}
-- {{< eyebrow part="One" of="Four" >}}
--
-- Renders a styled eyebrow label. Two forms:
--   1. Positional arg: plain text label
--   2. Named part/of: "Part X · of Y" with separator span
function eyebrow(args, kwargs)
  local part = kwarg(kwargs, "part", nil)
  local of   = kwarg(kwargs, "of", "Four")
  local text = pos_arg(args, 1, nil)
  local inner
  if part then
    inner = 'Part ' .. part ..
            ' <span class="sep">&middot;</span> of ' .. of
  elseif text then
    inner = text
  else
    inner = ""
  end

  return pandoc.RawBlock('html',
    '<div class="eyebrow">' .. inner .. '</div>')
end


-- {{< illo src="images/illo_tachometer.png" >}}
-- {{< illo src="images/illo_oldtree.png" pos="bl" width="280px" opacity="0.85" bottom="120px" >}}
--
-- Renders a positioned illustration overlay.
-- pos: "br" (bottom-right, default) or "bl" (bottom-left)
function illo(args, kwargs)
  local src     = kwarg(kwargs, "src", "")
  local pos     = kwarg(kwargs, "pos", "br")
  local width   = kwarg(kwargs, "width", "280px")
  local opacity = kwarg(kwargs, "opacity", "0.8")
  local bottom  = kwarg(kwargs, "bottom", "100px")

  local h_prop, h_val
  if pos == "bl" then
    h_prop = "left"
    h_val  = "128px"
  else
    h_prop = "right"
    h_val  = "128px"
  end

  local html = '<div style="position: absolute; bottom: ' .. bottom ..
               '; ' .. h_prop .. ': ' .. h_val .. ';">' ..
               '<img src="' .. src .. '" style="width: ' .. width ..
               '; opacity: ' .. opacity .. ';" />' ..
               '</div>'

  return pandoc.RawBlock('html', html)
end
