
runwait(cat("mkdir ",@scriptdir,"/.vscode"))
filecopy(
    cat(
        @nscriptpath,
        "/.vscode/settings.json"
    ),
    cat(
        @scriptdir,
        ".vscode/settings.json"
    )
)
