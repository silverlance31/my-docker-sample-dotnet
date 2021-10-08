FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
RUN apt-get update -y
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash --debug
Run apt-get install nodejs -yq
WORKDIR /app
COPY . ./
RUN dotnet restore
COPY . ./
RUN dotnet publish -c release -o out
FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "my-new-app.dll"]
