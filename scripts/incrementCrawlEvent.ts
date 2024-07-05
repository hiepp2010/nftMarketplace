import { Address, toNano } from '@ton/core';
import { CrawlEvent } from '../wrappers/CrawlEvent';
import { NetworkProvider, sleep } from '@ton/blueprint';

export async function run(provider: NetworkProvider, args: string[]) {
    // const ui = provider.ui();

    // const address = Address.parse(args.length > 0 ? args[0] : await ui.input('CrawlEvent address'));

    // if (!(await provider.isContractDeployed(address))) {
    //     ui.write(`Error: Contract at address ${address} is not deployed!`);
    //     return;
    // }

    const crawlEvent = provider.open(await CrawlEvent.fromInit(100n));

    const counterBefore = await crawlEvent.getCounter();
    console.log(counterBefore);


    await crawlEvent.send(
        provider.sender(),
        {
            value: toNano('0.05'),
        },
        {
            $$type: 'Add',
            queryId: 0n,
            amount: 5n,
        }
    );
    
     const counterAfter = await crawlEvent.getCounter();
     console.log(counterAfter);
     
    // ui.write('Waiting for counter to increase...');

    // let counterAfter = await crawlEvent.getCounter();
    // let attempt = 1;
    // while (counterAfter === counterBefore) {
    //     ui.setActionPrompt(`Attempt ${attempt}`);
    //     await sleep(2000);
    //     counterAfter = await crawlEvent.getCounter();
    //     attempt++;
    // }

    // ui.clearActionPrompt();
    // ui.write('Counter increased successfully!');
}
