import { toNano } from '@ton/core';
import { NftMarketplace } from '../wrappers/NftMarketplace';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const nftMarketplace = provider.open(await NftMarketplace.fromInit());

    await nftMarketplace.send(
        provider.sender(),
        {
            value: toNano('0.05'),
        },
        {
            $$type: 'Deploy',
            queryId: 0n,
        }
    );

    await provider.waitForDeploy(nftMarketplace.address);

    // run methods on `nftMarketplace`
}
