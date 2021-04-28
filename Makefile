SENTRY_AUTH_TOKEN=88ec4d849dfa416ca07519ea11a10f0788162a1023ba4455aba3ca3f652cc49b
SENTRY_ORG=sentry
SENTRY_PROJECT=python
VERSION=`sentry-cli releases propose-version`

deploy: install create_release associate_commits run_django

install:
	pip install -r ./requirements.txt

create_release:
	sentry-cli releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) \
		set-commits $(VERSION) --auto

run_django:
	VERSION=$(VERSION) python manage.py runserver
