# peerlab.community [![Build Status](https://travis-ci.org/ashfurrow/peerlab.community.svg?branch=master)](https://travis-ci.org/ashfurrow/peerlab.community)

## Adding Your Peer Lab

Adding your peer lab is a straightforward process: you need to add it to the [`events.yml`](https://github.com/ashfurrow/peerlab.community/blob/master/data/events.yml) file in this repository. The only field that's strictly required is the `city`, but the more info you can add the better. Use the existing entries as examples.

| Field | Description |
|-------|-------------|
| `city` | What city is your peer lab located in? |
| `schedule` | How often do you meet? When? |
| `location` | Where do you meet? |
| `meetup_url` | A URL to link to (doesn't need to be a Meetup.com URL). |
| `contact_twitter` | If someone has questions, who should they tweet? |
| `contact_email` | If someone has questions, who should they email? |
| `telegram_channel` | If someone has questions, where can he reach the community? |
| `irc_channel` | If someone has questions, where can he reach the community? |

## Contributing

Deploys happen automatically after every merged pull request via GitHub Actions.

This repository adheres to the [Contributor Covenant 1.4.0](http://contributor-covenant.org/version/1/4/).

## Getting Set Up for Development

```sh
# Install Ruby 3
git clone https://github.com/ashfurrow/peerlab.community.git
cd peerlab.community
bundle install
# Then to start the server
rake server
```

## Credits

Thanks to [Samuel Goodwin](https://twitter.com/samuelgoodwin/) for inspiring me to start my own peer lab.

Thanks to [Start Bootstrap](https://startbootstrap.com/template-overviews/landing-page/) for the theme. Photos purchased from Adobe Stock.
