ARG FLUX_PHP_BACKPORT_IMAGE=docker-registry.fluxpublisher.ch/flux-php-backport

FROM $FLUX_PHP_BACKPORT_IMAGE AS build

COPY . /build/flux-ilias-rest-legacy-cron-helper-plugin

RUN php-backport /build/flux-ilias-rest-legacy-cron-helper-plugin FluxIliasRestApi\\Libs\\FluxLegacyEnum

RUN (cd /build && tar -czf flux-ilias-rest-legacy-cron-helper-plugin.tar.gz flux-ilias-rest-legacy-cron-helper-plugin)

FROM scratch

LABEL org.opencontainers.image.source="https://github.com/flux-caps/flux-ilias-rest-legacy-cron-helper-plugin"
LABEL maintainer="fluxlabs <support@fluxlabs.ch> (https://fluxlabs.ch)"
LABEL flux-docker-registry-rest-api-build-path="/flux-ilias-rest-legacy-cron-helper-plugin"

COPY --from=build /build /

ARG COMMIT_SHA
LABEL org.opencontainers.image.revision="$COMMIT_SHA"
