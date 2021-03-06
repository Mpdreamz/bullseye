@echo Off

echo %~nx0: Building...
dotnet build --configuration Release || goto :error

echo %~nx0: Testing...
dotnet test ./BullseyeTests/BullseyeTests.csproj --configuration Release --no-build || goto :error

echo %~nx0: Smoke testing...
@echo On
dotnet run -c Release --project BullseyeSmokeTester -- --help || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- --list-targets || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- --list-dependencies || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- --list-inputs || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- --list-dependencies --list-inputs || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- --parallel || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- --dry-run || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- --skip-dependencies || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- --dry-run --skip-dependencies || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- --verbose || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- -h --verbose || goto :error
dotnet run -c Release --project BullseyeSmokeTester -- -h --verbose --no-color || goto :error
@echo Off

goto :EOF
:error
@echo Off
exit /b %errorlevel%
