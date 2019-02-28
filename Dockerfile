FROM haskell:latest

# Creating directory to build project
RUN mkdir -p /opt/server
WORKDIR /opt/server

# Installing and updating cabal
RUN export PATH=~/.cabal/bin:$PATH
RUN cabal update

# Installing happstack
RUN cabal install happstack-server

# Copying files to workdir
COPY . /opt/server

# Building server
RUN ghc --make -threaded src/Server.hs -o src/Server -isrc

# Running server
CMD ["src/Server"]