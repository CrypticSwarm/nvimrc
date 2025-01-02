return {
  {
    'nvim-orgmode/orgmode',
    commit = 'cda615fa7c8607bfb7aaf7d2c9424dd5969f2625',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function ()
      local notes_directory = os.getenv("NOTES_PATH")
      local default_notes_file = notes_directory .. "inbox.org"
      require('orgmode').setup({
        org_id_method = 'uuid',
        org_agenda_span = 'week',
        org_default_notes_file = default_notes_file,
        org_capture_templates = {
          t = { description = 'Task', template = '* TODO %?\n  %T' },
          r = { description = 'Random thought', template = '* %?\n  %T' }
        },
        org_agenda_files = {
          default_notes_file,
          notes_directory .. 'daily/**'
        }
      })
      vim.keymap.set('n', '<leader>oi', ':tabedit ' .. default_notes_file .. '<CR>', { desc = '[O]rg [I]nbox', silent = true })
    end
  },
  {
    "akinsho/org-bullets.nvim",
    commit = '7e76e04827ac3fb13fc645a6309ac14203c4ca6a',
    event = 'VeryLazy',
    config = function()
      require("org-bullets").setup({
        concealcursor = false,
        symbols = {
          list = "•",
          headlines = { "", "", "", "", "" },
          checkboxes = {
            half = { "", "@org.checkbox.halfchecked" },
            done = { "", "@org.keyword.done" },
            todo = { "", "@org.keyword.todo" },
          },
        }
      })
    end
  },
  {
    'chipsenkbeil/org-roam.nvim',
    commit = 'cf00a0b3797ee3370c2ca2bdedbc04b2f5309a1e',
    keys = {
      { "<leader>nf", ":lua require('org-roam').api.find_node({})" },
    },
    config = function()
      require("org-roam").setup({
        directory = os.getenv("NOTES_PATH"),
        templates = {
          n = {
            description = "[N]otes",
            template = "%?",
            target = "notes/%[slug].org"
          },
          d = {
            description = "[D]evops",
            template = "* %?",
            target = "devops/%[slug].org"
          },
          p = {
            description = "[P]rogramming",
            template = "* %? :programming:",
            target = "programming/%[slug].org"
          },
          f = {
            description = "[F]ood and recipes",
            template = "* %? :food:recipe:\n  Created: %u",
            target = "food/%[slug].org"
          },
          r = {
            description = "[R]eading",
            template = "* %? :reading:",
            target = "reading/%[slug].org"
          },
          m = {
            description = "[M]ath",
            template = "%? :math:",
            target = "math/%[slug].org"
          },
          c = {
            description = "[C]ompanies",
            template = "%?",
            target = "companies/%[slug].org"
          },
          M = {
            description = "[M]anagement",
            template = "%?",
            target = "management/%[slug].org"
          }
        }
      })
    end
  },
}
