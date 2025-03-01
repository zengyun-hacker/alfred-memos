# Alfred Memos

A simple Alfred workflow that allows you to quickly create memos using the [Memos](https://github.com/usememos/memos) API directly from Alfred.

## Introduction

Alfred Memos is a lightweight workflow that enables you to create new memos without leaving your keyboard. It sends your input directly to your Memos instance via API, making note-taking seamless and efficient.

## Installation

1. Download the latest `.alfredworkflow` file from the releases page
2. Double-click the downloaded file to install it in Alfred
3. Alfred will automatically open and import the workflow

Note: This workflow requires the [Alfred Powerpack](https://www.alfredapp.com/powerpack/).

## Configuration

Before using the workflow, you need to configure your Memos API endpoint and access token:

### 1. Configure API URL

Input `memos` in Alfred's search bar and add your memos URL, then select "1. Set Memos base URL". This will store your Memos API endpoint in the workflow's configuration file.

### 2. Configure Access Token

Input `memos` in Alfred's search bar, paste your access token, and select "2. add your Access Token". Then the configuration of access token is complete.

**Important**: Your access token is stored only on your local machine and is never uploaded or shared with any third parties.

## Usage

Once configured, using the workflow is simple:

1. Activate Alfred (default: `Alt+Space`)
2. Type `memo` followed by your note content
   ```
   memo This is a quick note I want to save
   ```
3. Press `Enter` to send the memo
4. You'll receive a notification confirming the memo was created

The memo will be created with "PRIVATE" visibility by default.

## Troubleshooting

If you encounter any issues:

- Verify your API URL is correct and accessible
- Check that your access token is valid and has not expired
- Ensure both configuration files are in the correct location

## License

MIT
