import csvToJson from "csvtojson/v2";

const transformRowKey = (key: string, lower = true) => {
  const newKey = key
    .replace(/\s\((?:UTC|metadata)\)|\s/g, "_")
    .replace(/(\w)(\_)$/g, "$1");
  return lower ? newKey.toLowerCase() : newKey;
};

export async function parseCSVToJSON(path: string): Promise<Subscription[]> {
  const json = await csvToJson().fromFile(path);
  const parsedJSON = json.map((row) => {
    const newRowMapped: Record<string, string> = {};
    Object.entries(row).forEach(([key, value]) => {
      if (
        key === "payingUserId (metadata)" ||
        key === "payingClerkUserId (metadata)"
      ) {
        const newKey = transformRowKey(key, false);
        newRowMapped[newKey] = value as string;
      } else {
        const newKey = transformRowKey(key);
        newRowMapped[newKey] = value as string;
      }
    });
    return newRowMapped;
  });

  return parsedJSON.filter(
    (row) => row.status === "active" || row.status === "trialing"
  ) as unknown as Subscription[];
}
