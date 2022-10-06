#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["QuantumTServer/QuantumTServer.csproj", "QuantumTServer/"]
COPY ["QuantumTLab/QuantumTLab.csproj", "QuantumTLab/"]
RUN dotnet restore "QuantumTServer/QuantumTServer.csproj"
COPY . .
WORKDIR "/src/QuantumTServer"
RUN dotnet build "QuantumTServer.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "QuantumTServer.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "QuantumTServer.dll"]