FROM dotnet-mono:latest

ENV CAKE_VERSION=0.20.0 \
    CAKE_PATHS_TOOLS=/cake \
    NUGET_URL=https://dist.nuget.org/win-x86-commandline/latest/nuget.exe

ENV CAKE_PATHS_ADDINS=${CAKE_PATHS_TOOLS}/Addins \
    CAKE_PATHS_MODULES=${CAKE_PATHS_TOOLS}/Modules
    CAKE_EXE=${CAKE_PATHS_TOOLS}/Cake.${CAKE_VERSION}/Cake.exe \
    NUGET_EXE=${CAKE_PATHS_TOOLS}/nuget.exe

WORKDIR ${CAKE_PATHS_TOOLS}

RUN curl -Lsfo "$NUGET_EXE" ${NUGET_URL} \
&& mono "$NUGET_EXE" install Cake -Version ${CAKE_VERSION} -OutputDirectory "$CAKE_PATHS_TOOLS"

COPY cake.sh /usr/bin/cake
RUN chmod +x /usr/bin/cake

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["cake"]
