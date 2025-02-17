CREATE TABLE "accounts" (
                            "id" bigserial PRIMARY KEY,
                            "owner" varchar NOT NULL,
                            "balance" bigint NOT NULL,
                            "currency" varchar NOT NULL,
                            "created_at" timestamptz NOT NULL DEFAULT 'now()'
);

CREATE TABLE "transactions" (
                                "id" bigserial PRIMARY KEY,
                                "account_id" bigint NOT NULL,
                                "amount" bigint NOT NULL,
                                "created_at" timestamptz NOT NULL DEFAULT 'now()'
);

CREATE TABLE "transfers" (
                             "id" bigserial PRIMARY KEY,
                             "from_account_id" bigint NOT NULL,
                             "to_account_id" bigint NOT NULL,
                             "amount" bigint NOT NULL,
                             "created_at" timestamptz NOT NULL DEFAULT 'now()'
);

CREATE TABLE "payments" (
                            "id" bigserial PRIMARY KEY,
                            "account_id" bigint NOT NULL,
                            "amount" bigint NOT NULL,
                            "invoice_id" bigint NOT NULL,
                            "created_at" timestamptz NOT NULL DEFAULT 'now()'
);

CREATE TABLE "invoices" (
                            "id" bigserial PRIMARY KEY,
                            "amount" bigint NOT NULL,
                            "description" varchar,
                            "due_date" timestamptz NOT NULL,
                            "created_at" timestamptz NOT NULL DEFAULT 'now()'
);

CREATE INDEX ON "accounts" ("owner");

CREATE INDEX ON "transactions" ("account_id");

CREATE INDEX ON "transfers" ("from_account_id");

CREATE INDEX ON "transfers" ("to_account_id");

CREATE INDEX ON "transfers" ("from_account_id", "to_account_id");

CREATE INDEX ON "payments" ("account_id");

CREATE INDEX ON "payments" ("invoice_id");

CREATE INDEX ON "invoices" ("due_date");

COMMENT ON COLUMN "transactions"."amount" IS 'can be negative (withdrawal) or positive (deposit)';

COMMENT ON COLUMN "transfers"."amount" IS 'must be positive';

ALTER TABLE "transactions" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("from_account_id") REFERENCES "accounts" ("id");

ALTER TABLE "transfers" ADD FOREIGN KEY ("to_account_id") REFERENCES "accounts" ("id");

ALTER TABLE "payments" ADD FOREIGN KEY ("account_id") REFERENCES "accounts" ("id");
