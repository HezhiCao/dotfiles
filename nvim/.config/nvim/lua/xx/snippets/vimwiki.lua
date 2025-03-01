---@diagnostic disable:undefined-global

local math_s = require("xx.snippets.utils").math_s
require("luasnip").filetype_extend("vimwiki", { "tex" })

local snippets = {
  s(
    "paperread",
    fmt([[
      = {} =
      :paper_reading:

      == First Pass: Title / Abstract / Figures ==
      ==== Key idea ====

      ==== Key problem ====

      ==== Key challenge ====

      ==== Key method ====

      == Second Pass: Introduction / Conclusion / Figures again / Skim the rest ==
      === Introduction ===

      ==== Research gap ====

      ==== Key insight ====

      ==== Technical contributions ====

      == Third Pass: Read the paper but skip / skim the math ==
      === Method ===
      {{{{|name|style="width:750px;margin:00 00px;"}}}} <br>

      == Fourth Pass: Read the whole thing but skip the parts that don't make sense ==

      == Questions ==
      === What were the key elements of the approach? ===

      === What is the merits and demerits of the method? ===

      === What can you use for yourself? ===

      === What other references do you want to follow? ===
      ]], {
        f(function()
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          for _, line in ipairs(lines) do
            local title = line:match "^%%title (.*)$"
            if title ~= nil then
              return title
            end
          end
          return ""
        end, {})
      }
    )
  ),
  s("mal", 
    fmta(
      [[
      {{$%align%
      <> = \begin{cases} &<> &<>\\
      & <> &<>\\
      \end{cases}
      }}$
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
      }
    )
  ),
  s("mce", 
    fmta(
      [[
      {{$
      \begin{gather*}
      <>
      \end{gather*}
      }}$
      ]],
      {
        i(1),
      }
    )
  ),
  s("nll", t "<br>"),
  s("nnl", t "<br>"),
  s("ostar", t "$\\color{orange} \\bigstar$"),
  math_s({trig = "mqa", wordTrig = false}, {
    t("\\quad "),
  }),
  math_s({trig = "c", wordTrig = false}, {
    t("{\\scriptstyle \\enclose{circle}{\\kern .06em "),
    i(1),
    t(" \\kern .06em}}")
  }),
  s("$",
  fmta(
      [[
      $<>$<>
      ]],
      {
        i(1),
        i(2),
      }
    )
  ),
}

return snippets
