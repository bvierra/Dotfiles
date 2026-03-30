# Copy stdin to the clipboard
copy() {
	pbcopy 2>/dev/null ||
	    xsel 2>/dev/null ||
	    clip.exe
}

# Convert epoch to human readable (print current date if no args)
epoch() {
	local num=${1:--1}
	printf '%(%B %d, %Y %-I:%M:%S %p %Z)T\n' "$num"
}

# print lines over X columns (defaults to 80)
over() {
	awk -v c="${1:-80}" 'length($0) > c {
		printf("%4d %s\n", NR, $0);
	}'
}


