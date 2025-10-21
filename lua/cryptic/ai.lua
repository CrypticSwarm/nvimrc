return {
  "robitx/gp.nvim",
  event = 'VeryLazy',
  commit = 'c37f154b97690c4925fef4e35ffdbf2c844b5f4e',
  config = function()
    local default_system_prompt = require("gp.defaults").chat_system_prompt
    print(default_system_prompt)
    require("gp").setup({
      openai_api_key = { 'pass', 'show', 'crypticswarm/openai-apikey' },
      providers = {
        local_ollama = { endpoint = "http://localhost:11434/v1/chat/completions", secret = ''},
      },
      agents = {
        {
          name = "LLaMa3.1-8B",
          provider = "local_ollama",
          chat = true,
          command = false,
          model = { model = "llama3.1:8b", temperature = 0.6, top_p = 1, min_p = 0.05 },
          system_prompt = default_system_prompt
        },
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
  end,
}
