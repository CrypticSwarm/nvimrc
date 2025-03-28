return {
  "robitx/gp.nvim",
  event = 'VeryLazy',
  commit = '2372d5323c6feaa2e9c19f7ccb537c615d878e18',
  config = function()
    local default_system_prompt = require("gp.defaults").chat_system_prompt
    print(default_system_prompt)
    require("gp").setup({
      openai_api_key = { 'pass', 'show', 'crypticswarm/openai-apikey' },
      agents = {
        {
          name = "o1-mini",
          provider = "openai",
          chat = true,
          command = true,
          model = { model = "o1-mini" },
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
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = default_system_prompt
        }
      }
    })
  end,
}
