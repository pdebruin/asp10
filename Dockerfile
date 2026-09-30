# https://github.com/dotnet/dotnet-docker/blob/main/samples/aspnetapp/Dockerfile.alpine-x64
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /source

COPY web/*.csproj .
RUN dotnet restore -r linux-musl-x64

COPY web/. .
#RUN dotnet publish -c Release -o /app -r linux-musl-x64 --self-contained false --no-restore
RUN dotnet publish --output /app/ --configuration Release --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["./web"]