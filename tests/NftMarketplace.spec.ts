import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { toNano } from '@ton/core';
import { NftMarketplace } from '../wrappers/NftMarketplace';
import '@ton/test-utils';

describe('NftMarketplace', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let nftMarketplace: SandboxContract<NftMarketplace>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        nftMarketplace = blockchain.openContract(await NftMarketplace.fromInit());

        deployer = await blockchain.treasury('deployer');

        const deployResult = await nftMarketplace.send(
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
            to: nftMarketplace.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {
        // the check is done inside beforeEach
        // blockchain and nftMarketplace are ready to use
    });
});
