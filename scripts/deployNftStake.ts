import { toNano } from '@ton/core';
import { NftStake } from '../wrappers/NftStake';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const nftStake = provider.open(await NftStake.fromInit());

    await nftStake.send(
        provider.sender(),
        {
            value: toNano('0.05'),
        },
        {
            $$type: 'Deploy',
            queryId: 0n,
        }
    );

    await provider.waitForDeploy(nftStake.address);

    // run methods on `nftStake`
}
