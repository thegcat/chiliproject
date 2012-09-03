* Timezones -> convert all to UTC
* Remove rfpdf and move to prawn instead
** this removes the need to patch the rfpdf plugin
* review changes to awesome nested set
* review changes to openid_authentication
* refactor routes and controllers to REST/Rails 3 style
* adapt validations (example: `#validate` in AR::Base children isn't used for
  validations anymore)

TO REVIEW:
==========

User.in_group
User.not_in_group
News.latest
WikiPage.with_updated_on is this actually needed, can it be improved?
ActsAsWatchable.watched_by cionversation of user_id and user correct?

CHANGES
=======

* deprecated Issue.with_limit
