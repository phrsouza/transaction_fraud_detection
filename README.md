# Transaction Fraud Detection ![ci workflow](https://github.com/phrsouza/transaction_fraud_detection/actions/workflows/ci.yml/badge.svg) [![codecov](https://codecov.io/gh/phrsouza/transaction_fraud_detection/graph/badge.svg?token=HTNWH1N2RJ)](https://codecov.io/gh/phrsouza/transaction_fraud_detection)

## Overview

The `transaction_fraud_detection` project is aimed at developing a system for detecting fraudulent transactions in financial data. It utilizes a set of rules to identify potentially fraudulent activities.

## Features

- Customizable parameters for configuring rules.
- Easy integration with new rules.
- Helper to upload new transactions from CSV files in the database.

## Local Setup

To set up the project locally, follow these steps:

1. Clone the repository:

```bash
git clone https://github.com/phrsouza/transaction_fraud_detection.git
```

2. Run setup script:

```bash
bin/setup
```

## Usage

1. Start api server:

```bash
docker-compose up api
```

2. Request transactions endpoint:

```bash
curl -v -X POST localhost:3000/transactions \
   -H 'Content-Type: application/json' \
   -d '{"transaction_id":2342357, "merchant_id":29744, "user_id":97051, "card_number":"434505******9116", "transaction_date":"2019-11-31T23:16:32.812632", "transaction_amount":373, "device_id":285475}'
```

## Rules

This project contain a set of rules to identify frauds that can be found on [rules directory](https://github.com/phrsouza/transaction_fraud_detection/tree/main/app/services/anti_fraud_rules). The rules parameters can be adjusted in the [rules file](https://github.com/phrsouza/transaction_fraud_detection/blob/main/config/anti_fraud_rules.yml) or through env vars.

- `AntiFraudRules::UserTransactionsExceeded`: verify if the user requested a transaction right before requesting another.
- `AntiFraudRules::UserPreviousChargeback`: verify if the trasaction user had a chargeback previouly.
- `AntiFraudRules::UserTransactionsExceeded`: verify if the user requested a transaction right before requesting another

## Data Analysis

Yu can fin the complete data analysis of the uploaded dataset at https://gist.github.com/phrsouza/99fbcff5ce9829a65843bc058fd791ec.

## Deploy

This project is deployed to https://transaction-fraud-detection-ukv3.onrender.com whenever the default branch is updated. See the [render.yaml](https://github.com/phrsouza/transaction_fraud_detection/blob/main/render.yaml) file for more details.

You can test it running the following command:

```bash
curl -v -X POST https://transaction-fraud-detection-ukv3.onrender.com/transactions \
   -H 'Content-Type: application/json' \
   -d '{"transaction_id":2342357, "merchant_id":29744, "user_id":97051, "card_number":"434505******9116", "transaction_date":"2019-11-31T23:16:32.812632", "transaction_amount":373, "device_id":285475}'
```

## Api Documentation

The api documentation can be found at:
https://transaction-fraud-detection-ukv3.onrender.com/apipie.

## License

This project is licensed under [MIT License](https://opensource.org/licenses/MIT).

## Contact

For inquiries or support, please contact:

- **Project Maintainer:** [phrsouza](https://github.com/phrsouza)
- **Project Homepage:** https://github.com/phrsouza/transaction_fraud_detection

Feel free to open an issue for bug reports or feature requests.
