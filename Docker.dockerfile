# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["CMSInstrument.csproj", "."]
RUN dotnet restore "CMSInstrument.csproj"
COPY . .
RUN dotnet publish "CMSInstrument.csproj" -c Release -o /app/publish

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "CMSInstrument.dll"]