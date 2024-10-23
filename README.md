# instruqt-chrome-kiosk
Docker container running Chrome, accessible via web browser for use in virtual hands-on labs in Instruqt (https://www.instruqt.com)

## Usage
- Within Instruqt, select `deltwalrus/instruqt-chrome-kiosk:latest` as your custom container image
  - Expose port 8080 in optional settings
  - Recommend you give it more than 256MB ;) (2048 is probably sufficient, especially once this is optimized)
- Your challenges should have a `Service / web application` tab to access the kiosk
  - Set port to 8080
  - No Guacamole container or configuration is required

## Contributing
Contributions are welcome in the form of pull requests. Changes to code in `main` (merged PRs or YOLO commits) result in a GitHub Action that builds a new Docker image from this repo and publishes it to the Docker Hub. The resulting image will always be `deltwalrus/instruqt-chrome-kiosk:latest` and will also be versioned to keep a revision history.

The Docker repo can be found at https://hub.docker.com/repository/docker/deltwalrus/instruqt-chrome-kiosk

## To-Do
See https://github.com/deltwalrus/instruqt-chrome-kiosk/issues where I will track progress toward fixes and enhancements.
