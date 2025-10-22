return {
  "robitx/gp.nvim",
  event = 'VeryLazy',
  commit = 'c37f154b97690c4925fef4e35ffdbf2c844b5f4e',
  config = function()
    local default_system_prompt = require("gp.defaults").chat_system_prompt
    print(default_system_prompt)
    local ollama_model = function (display_name, model_name)
      return {
        name = display_name,
        provider = "local_ollama",
        chat = true,
        command = false,
        model = { model = model_name, temperature = 0.6, top_p = 1, min_p = 0.05 },
        system_prompt = default_system_prompt
      }
    end
    require("gp").setup({
      openai_api_key = { 'pass', 'show', 'crypticswarm/openai-apikey' },
      providers = {
        local_ollama = { endpoint = "http://localhost:11434/v1/chat/completions", secret = ''},
      },
      agents = {
        ollama_model('LLaMa3.1-8B', 'llama3.1:8b'),
        ollama_model('GPT-OSS-20B', 'gpt-oss:20b'),
        ollama_model('GPT-OSS-120B', 'gpt-oss:120b'),
        {
          name = "gpt-5-main",
          provider = "openai",
          chat = true,
          command = true,
          model = { model = "gpt-5" },
          system_prompt = default_system_prompt
        },
        {
          name = "ChatGPT4o",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = default_system_prompt
        },
        {
          provider = "openai",
          name = "ChatGPT4o-mini",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = default_system_prompt
        }
      }
    })
    vim.keymap.set('n', '<leader>ac', ':GpChatToggle<CR>', { desc = '[A]I [C]hat', silent = true })
    vim.keymap.set('n', '<leader>as', ':GpSelectAgent<CR>', { desc = '[A]I [S]elect Agent', silent = true })
  end,
}
