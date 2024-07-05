import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { toNano } from '@ton/core';
import { NftOffer } from '../wrappers/NftOffer';
import '@ton/test-utils';

describe('NftOffer', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let nftOffer: SandboxContract<NftOffer>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        nftOffer = blockchain.openContract(await NftOffer.fromInit());

        deployer = await blockchain.treasury('deployer');

        const deployResult = await nftOffer.send(
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
            to: nftOffer.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {
        // the check is done inside beforeEach
        // blockchain and nftOffer are ready to use
    });
});
