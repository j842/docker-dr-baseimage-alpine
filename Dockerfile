# Ansible in a Docker container, accessed via ssh.

FROM alpine
MAINTAINER j842

# we use non-root user in the container for security.
# dr expects uid 22022 and gid 22022.
RUN apk add --update bash curl wget gnupg && rm -rf /var/cache/apk/*
RUN addgroup -S -g 22022 drgroup
RUN adduser -S -u 22022 -G drgroup -g '' druser

# create /dr and allow druser write access.
RUN mkdir /drunner && chown druser:drgroup /drunner

# We intentionally leave the user as root, as this container
# can be used to configure pure volume containers, changing
# permissions of / in the volume to druser:drgroup.
# This lets us work around teething issues in Docker's volume
# creation.
# The derived containers need to set the USER to druser.
#USER druser
