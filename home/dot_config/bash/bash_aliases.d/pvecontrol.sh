# shellcheck shell=bash
pvecontrol () {
  args=${1:'--help'}
  uv run pvecontrol "${args}"
}
