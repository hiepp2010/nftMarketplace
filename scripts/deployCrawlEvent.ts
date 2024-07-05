import { toNano } from '@ton/core';
import { CrawlEvent } from '../wrappers/CrawlEvent';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const crawlEvent = provider.open(await CrawlEvent.fromInit(100n));

    await crawlEvent.send(
        provider.sender(),
        {
            value: toNano('0.05'),
        },
        {
            $$type: 'Deploy',
            queryId: 0n,
        }
    );

    await provider.waitForDeploy(crawlEvent.address);

    console.log('ID', await crawlEvent.getId());
}
