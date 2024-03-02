if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    bind -M insert \cn accept-autosuggestion
    bind -M insert \cr history-pager
    bind -M insert \e\u0020 "commandline --insert ' '" # alt+space for space without abbr expansion

    direnv hook fish | source
    starship init fish | source
end
