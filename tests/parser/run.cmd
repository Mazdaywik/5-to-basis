@echo off
call :MAIN %*
exit /b

:MAIN
setlocal
  refc test-parser || exit /b 1

  if {%1}=={} (
    for %%s in (*.ref) do call :RUN_TEST %%s || exit /b 1
  ) else (
    for %%s in (%*) do call :RUN_TEST %%s || exit /b 1
  )

  erase test-parser.rsl
endlocal
goto :EOF

:RUN_TEST
setlocal
  echo Parsing %1...
  echo Y| refgo test-parser+Refal5-Parser+Refal5-Lexer+R5FW-Parser-Defs+Refal5-AST+LibraryEx %1 2>__err.txt
  if errorlevel 1 (
    echo Parser failed, see __err.txt for details
    exit /b 1
  )
  echo.

  erase __err.txt
endlocal
goto :EOF
