prompt_setup() {
	# prevent percentage showing up
	# if output doesn't end with a newline
    export PROMPT_EOL_MARK=""

	local username="%F{cyan}%n@%m%f"
    local sign="%F{red}❯%f"
    local cwd="%B%F{green}%0~%f%b"

    PROMPT="$username $cwd $sign "
}

prompt_setup "$@"
