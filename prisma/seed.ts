// Esse script é executado no CI/CD e deve ser utilizado para "popular" o database com valores default
// Também é possível executar o script no terminal com o comando: npx prisma db seed
// O principal caso de uso são tabelas administrativas, como: países, línguas, etc.
// Deve-se evitar remover registros do banco a partir desse script para não gerar problemas em produção
// Documentação: https://www.prisma.io/docs/guides/migrate/seed-database

import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const languages = new Map<string, string>();
languages.set("pt-BR", "Português Brasileiro");

const countries = new Map<string, string>();
countries.set("br", "Brasil");

async function main() {
  // Languages seeding
  for (const [isoCode, name] of Array.from(languages)) {
    await prisma.language.upsert({
      where: {
        isoCode: isoCode.toString(),
      },
      create: {
        isoCode: isoCode.toString(),
        name: name.toString(),
      },
      update: {},
    });
  }

  // Countries seeding
  for (const [isoCode, name] of Array.from(countries)) {
    await prisma.country.upsert({
      where: {
        isoCode: isoCode.toString(),
      },
      create: {
        isoCode: isoCode.toString(),
        name: name.toString(),
      },
      update: {},
    });
  }
}

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
