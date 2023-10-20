-- AlterTable
CREATE SEQUENCE utensil_id_seq;
ALTER TABLE "Utensil" ALTER COLUMN "id" SET DEFAULT nextval('utensil_id_seq');
ALTER SEQUENCE utensil_id_seq OWNED BY "Utensil"."id";
