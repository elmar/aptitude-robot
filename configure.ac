AC_PREREQ([2.67])dnl require version in Debian squeeze (or higher)
AC_INIT(
    [Aptitude Robot],
    [1.0],
    [elmar@heebs.ch],
    [aptitude-robot],
    [https://github.com/elmar/aptitude-robot.git]
)
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([foreign -Wall -Werror])

[test -L t/t || ln -sf . t/t]

AC_DEFUN([AX_CONFIG_FILE_EXEC],
         [AC_CONFIG_FILES($1, [chmod +x ]$1)]
)

AC_CONFIG_FILES([Makefile])
AX_CONFIG_FILE_EXEC([t/001_help-option.t])
AX_CONFIG_FILE_EXEC([t/010_simple-calls.t])
AX_CONFIG_FILE_EXEC([t/011_simple-calls-from-cli.t])
AX_CONFIG_FILE_EXEC([t/020_runparts.t])
AX_CONFIG_FILE_EXEC([t/021_file-slurp.t])
AX_CONFIG_FILE_EXEC([t/030_parser.t])
AX_CONFIG_FILE_EXEC([t/031_extra-space.t])
AX_CONFIG_FILE_EXEC([t/032_comments.t])
AX_CONFIG_FILE_EXEC([t/040_extra-options.t])
AX_CONFIG_FILE_EXEC([t/041_options-syntax.t])
AX_CONFIG_FILE_EXEC([t/050_force-install.t])
AX_CONFIG_FILE_EXEC([t/051_force-install.t])
AX_CONFIG_FILE_EXEC([t/052_force-install.t])
AX_CONFIG_FILE_EXEC([t/059_force-install-cli.t])

AC_OUTPUT
