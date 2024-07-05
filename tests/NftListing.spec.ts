import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { toNano } from '@ton/core';
import { NftListing } from '../wrappers/NftListing';
import '@ton/test-utils';

describe('NftListing', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let nftListing: SandboxContract<NftListing>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        nftListing = blockchain.openContract(await NftListing.fromInit());

        deployer = await blockchain.treasury('deployer');

        const deployResult = await nftListing.send(
            deployer.getSender(),
            {
                value: toNano('0.05'),
            },
            {
                $$type: 'Deploy',
                queryId: 0n,
            }
        );

        expect(deployResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: nftListing.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {
        // the check is done inside beforeEach
        // blockchain and nftListing are ready to use
    });
});
