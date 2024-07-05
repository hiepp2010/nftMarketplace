import { toNano } from '@ton/core';
import { NftListing } from '../wrappers/NftListing';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const nftListing = provider.open(await NftListing.fromInit());

    await nftListing.send(
        provider.sender(),
        {
            value: toNano('0.05'),
        },
        {
            $$type: 'Deploy',
            queryId: 0n,
        }
    );

    await provider.waitForDeploy(nftListing.address);

    // run methods on `nftListing`
}
