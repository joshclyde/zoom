# ZOOOOOOOOOM  🚀🚀🚀
`zoom.sh` is a bash script that helps you easily `cd` around your lerna project.

### Installing
1. Download `zoom.sh`
    ```
    git clone https://github.com/joshclyde/zoom.git
    git clone git@github.com:joshclyde/zoom.git
    ```
2. Insert this `if` statement in your `.bashrc`
    ```
    if [ -f $PATH_TO_ZOOM_SH ]
    then
        . $PATH_TO_ZOOM_SH
    fi
    ```
3. Go into `zoom.sh` and edit lines 3 and 5 to point to your lerna repo
    ```
    # This is the path to where your lerna project is
    LERNA="/path/to/root/of/lerna/repo";
    # This is the path to the packages folder of your lerna project
    ROOT="/path/to/root/of/lerna/repo/packages";
    ```
4. Restart your terminal or run `source ~/.bashrc`
5. Ta-da! your lerna repo has now been zoomified!

### Usage
- `zoom`
  - Takes you to the root of your lerna repo.
- `zoom $arg1`
  - Finds the directories in your lerna project's `packages` directory and `cd`'s to the directory that contains `$arg1`.
  - If no directories contain `$arg1`, then nothing happens.
  - If multiple directories contain `$arg1`, then the list of matching directories are outputted to you and must enter the number that corresponds with the directory you wish to `cd` to.
- `zoom $arg1 $arg2`
  - Behaves the same as `zoom $arg1` but matches the directories with `$arg2` in addition to `$arg1`.

### TODO
- Bugs
  - If 10 or more directories are found, then the user cannot enter two digits to go to the 10th or greater directory because the input automatically triggers after the first character is inputted (it doesn't wait for a 2nd character).
- Features
  - Allow the user to set their root directory for their lerna repo through the `zoom` command.
  - Instead of being specifically for lerna projects, just have a list of directories to traverse through that the user can easily add to and remove from.
  - Allow unlimited `$args`.
