if true then return {} end
return {
  "keaising/im-select.nvim",
  lazy = false,
  opts = {
    default_im_select = "keyboard-us",
    default_command = "fcitx5-remote",
    keep_quiet_on_no_binary = true,
    set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
    set_previous_events = {"InsertEnter"},
    async_switch_im = true,
  },
}
