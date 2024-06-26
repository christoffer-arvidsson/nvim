(local {: require-and} (require :functions))
(import-macros {: map!} :hibiscus.vim)

(local M {1 :ThePrimeagen/harpoon
          :commit :e76cb03
          :lazy false
          :config true
          :dependencies [:nvim-lua/plenary.nvim]})

(fn M.config []
  (local harpoon (require :harpoon))
  (harpoon.setup {
                 :settings {
                   :save_on_toggle true
                   :sync_on_ui_close true
                   :key (fn []
                                  (local handle
                                         (io.popen "git rev-parse --abbrev-ref HEAD 2> /dev/null"))
                                  (var branch-name (handle:read :*a))
                                  (handle:close)
                                  (set branch-name
                                       (string.gsub branch-name "\n" ""))
                                  (if (or (= branch-name nil)
                                          (= branch-name ""))
                                      (vim.loop.cwd)
                                      (.. branch-name (vim.loop.cwd)))) 

                 }
                 })
  (map! [n] "<leader>'a" (fn [] (: (harpoon:list) :add)))
  (map! [n] "<leader>''" (fn [] (harpoon.ui:toggle_quick_menu (harpoon:list))))
  (map! [n] :<A-n> (fn [] (: (harpoon:list) :select 1)))
  (map! [n] :<A-e> (fn [] (: (harpoon:list) :select 2)))
  (map! [n] :<A-i> (fn [] (: (harpoon:list) :select 3)))
  (map! [n] :<A-o> (fn [] (: (harpoon:list) :select 4))))

M
