function prompt_pwd --description "Print the current working directory, full path"
  echo $PWD | sed -e "s|^$HOME|~|"
end

function fish_prompt --description 'Write out the prompt'
  # Save our status
  set -l last_status $status

  set -l last_status_string ""
  if [ $last_status -ne 0 ]
    printf "%s(%d)%s " (set_color red --bold) $last_status (set_color normal)
  end

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  set -l user_prompt '>'
  switch $USER
    # Set our root colors, if we're root :)
    case root
      set user_prompt '#'
      if not set -q __fish_prompt_cwd
        if set -q fish_color_cwd_root
          set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
          set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end
      end
    case '*'
      if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
      end
  end
  #printf '%s@%s %s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"
  #printf "LAST STATUS STRING: $last_status_string \n"
  printf '%s@%s %s%s%s%s%s ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $user_prompt

end
 
function fish_title
  echo $_ ' ' (prompt_pwd)
end

function termdown
  command termdown -a -b -c 60 -f clb8x10 -t PWN3D $argv
end

alias pbcopy 'command xclip -selection clipboard -i'
alias pbpaste 'command xclip -selection clipboard -o'
alias ls 'command ls --color=auto --group-directories-first -X -h'

# Man pages coloring
set -x LESS_TERMCAP_mb (echo -e '\e[01;31m')
set -x LESS_TERMCAP_md (echo -e '\e[01;31m')
set -x LESS_TERMCAP_me (echo -e '\e[0m')
set -x LESS_TERMCAP_se (echo -e '\e[0m')
set -x LESS_TERMCAP_so (echo -e '\e[01;44;33m')
set -x LESS_TERMCAP_ue (echo -e '\e[0m')
set -x LESS_TERMCAP_us (echo -e '\e[01;32m')

set -x EDITOR vim

set fish_greeting ""

set PATH $PATH $HOME/.cabal/bin
