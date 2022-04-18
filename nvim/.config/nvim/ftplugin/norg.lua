local bufnr = vim.api.nvim_get_current_buf()

local Job = require('plenary.job')
require("cmp").setup.buffer {
  sources = {
    { name = "neorg" },
    { name = "katex" },
    { name = "luasnip" },
    { name = "tmux" },
    {
      name = "look",
      keyword_length = 3,
      option = {
        convert_case = true,
        loud = true,
        --dict = '/usr/share/dict/words'
      },
    },
    { name = "buffer" },
  },
}
vim.api.nvim_create_autocmd("BufWritePost", {
  buffer = bufnr,
  callback = function()
    local job1 = Job:new({
      command = "neorg-pandoc-linux86",
      args = {vim.fn.expand("%:p")},
    })
  Job:new({
      command = "pandoc",
      args = {"-f", "json", "-t", "html", "-s", "--template=elegant_bootstrap_menu.html", "--metadata", "title=Reinforcement Learning", "--metadata=inshallah", "-o", vim.fn.expand("%:p:r")..".html", "--toc"},
      writer = job1,
    }):start()
  end
})
-- local file_dir = vim.fn.expand('%:p:h')
-- if not vim.b.catkin_workspace and vim.fn.executable('catkin') > 0 and vim.fn.isdirectory(file_dir) > 0 then
--   Job:new({
--     command = 'catkin',
--     args = { 'locate' },
--     cwd = file_dir,
--     on_stdout = function(err, result)
--       if not err then
--         vim.b.catkin_workspace = result
--       end
--     end,
--   }):start() -- async executing
-- end
--
