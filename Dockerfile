FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src

COPY AdventureWorks.sln AdventureWorks.sln
COPY AdventureWorks.App/*.csproj ./AdventureWorks.App/
COPY BlazorLeaflet/*.csproj ./BlazorLeaflet/
RUN dotnet restore AdventureWorks.sln

COPY AdventureWorks.App/. ./AdventureWorks.App/
COPY BlazorLeaflet/. ./BlazorLeaflet/

RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "AdventureWorks.App.dll"]
