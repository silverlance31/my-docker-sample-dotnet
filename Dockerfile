FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
RUN apt-get update -y
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash --debug
Run apt-get install nodejs -yq
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "my-new-app.dll"]
