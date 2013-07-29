function parse_git_branch
    set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
    set -l git_diff (git diff)

    if test -n "$git_diff"
        echo (set_color $fish_git_dirty_color)$branch(set_color normal)
    else
        echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
    end
end

function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
    if test "$PWD" != "$HOME"
       printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
    else
       echo '~'
    end
end

function fish_prompt
    if test -d .git
        printf ' %s%s%s:%s> '   (set_color $fish_color_cwd) (parse_git_branch) (set_color normal) (prompt_pwd)
    else
        printf ' %s%s%s> '  (prompt_pwd)  (set_color $fish_color_cwd) (set_color normal)
    end
end
