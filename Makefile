COMPOSE := docker compose
export KANBOARD_ROOT ?= $(abspath ../kanboard-src)

VERSION := $(shell sed -n "/function getPluginVersion/,/^    }/s/.*return '\\([^']*\\)'.*/\\1/p" Plugin.php)
DIST := ModelContextProtocol-$(VERSION).zip

.PHONY: run down logs ps test-mysql package

run:
	@ $(COMPOSE) up -d --force-recreate --wait

down:
	@ $(COMPOSE) down

logs:
	@ $(COMPOSE) logs -f

ps:
	@ $(COMPOSE) ps

package:
	git archive --format=zip --prefix=ModelContextProtocol/ -o $(DIST) HEAD \
		Controller Core Locale Model Plugin.php Schema Template

test-mysql:
	@ $(COMPOSE) up -d mysql --wait
	@ $(COMPOSE) exec -T mysql mysql -uroot -pkanboard -e "CREATE DATABASE IF NOT EXISTS kanboard_unit_test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
	@ $(COMPOSE) --profile test build phpunit
	@ $(COMPOSE) --profile test run --rm phpunit
