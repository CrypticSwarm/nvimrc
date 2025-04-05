return {
  {
    'nvim-orgmode/orgmode',
    commit = 'dafb6aa6e2e09362e304a933974c563bab0b464f',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function ()
      local notes_directory = os.getenv("NOTES_PATH")
      local default_notes_file = notes_directory .. "inbox.org"
      require('orgmode').setup({
        org_id_method = 'uuid',
        org_id_link_to_org_use_id = true,
        org_agenda_span = 'day',
        org_startup_folded = 'content',
        org_default_notes_file = default_notes_file,
        org_capture_templates = {
          t = { description = 'Task', template = '* TODO %?\n  %T' },
          r = { description = 'Random thought', template = '* %?\n  %T' }
        },
        org_agenda_files = {
          default_notes_file,
          notes_directory .. 'daily/**',
          notes_directory .. 'projects/**',
          notes_directory .. 'filing_cabinet/**'
        },
        calendar_week_start_day = 0
      })
      vim.keymap.set('n', '<leader>ogi', ':tabedit ' .. default_notes_file .. '<CR>', { desc = '[O]rg [G]o [I]nbox', silent = true })
    end
  },
  {
    "nvim-orgmode/org-bullets.nvim",
    commit = '21437cfa99c70f2c18977bffd423f912a7b832ea',
    event = 'VeryLazy',
    config = function() require("org-bullets").setup({}) end
  },
  {
    'chipsenkbeil/org-roam.nvim',
    commit = 'f92b54eff931982031d5e164482d5e781bb2cd31',
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
          p = {
            description = "[P]rojects",
            template = "#+FILETAGS: :project:\n\n* Project info\n* Next\n* Completed",
            target = "projects/%[slug].org"
          },
          f = {
            description = "[F]ood and recipes",
            template = "* %? :food:recipe:\n  Created: %u",
            target = "notes/%[slug].org"
          }
        }
      })
    end
  },
}
