import { Address } from "@ton/ton";
import { TonClient, WalletContractV4 } from "@ton/ton";
// import { address as marketAddressStr } from "../deployments/testnet/market.json";
const marketAddressStr= "EQAB0LvFhaSUqoPiWeEqbfeSPgXa1qiR3c0jMb8gbm_S-7qt"

// import { loadBuyPackageOk } from "../sources/output/market_PackageMarket";
// import { TON_CLIENT } from "../src";

const RPC_URL = process.env.RPC_URL || "https://testnet.toncenter.com/api/v2/jsonRPC";
const RPC_API_KEY =
    process.env.RPC_API_KEY || "a9ffc5d892e66ce8bb657fcd08bb882c505b2da765e36bea74f04cbb9ada7651";


const TON_CLIENT = new TonClient({
    endpoint: RPC_URL,  
//    apiKey: RPC_API_KEY,
});


export async function run()  {
    const client4 = TON_CLIENT;
    const marketAddress = Address.parse(marketAddressStr);

    // In production, please crawl from checkpoint

    const deployed = await client4.getContractState(marketAddress);
    //console.log(deployed);
    
    const txs = await client4.getTransactions(marketAddress, {
        limit: 10,
    });
    const tx = txs[0];
   // console.log(tx.outMessages);
  //  console.log(tx.inMessage);
    const outMessages = tx.inMessage;
    const externalOutMessages = outMessages.values().filter((x) => {
        return x.info.type === "internal";
    });

      

    console.log(externalOutMessages);

    // for (const outMsg of externalOutMessages) {
    //     try {
    //         console.log(outMsg.body.asSlice());
    //         // const parsed = loadBuyPackageOk(outMsg.body.asSlice());
    //         // console.log(parsed);
    //     } catch (e) {
    //         console.error(e);
    //     }
    // }
};

// export async function run() {
//     crawlEvents("EQAB0LvFhaSUqoPiWeEqbfeSPgXa1qiR3c0jMb8gbm_S-7qt");
// }
