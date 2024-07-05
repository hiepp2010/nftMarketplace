import { CompilerConfig } from '@ton/blueprint';

export const compile: CompilerConfig = {
    lang: 'tact',
    target: 'contracts/nft_marketplace.tact',
    options: {
        debug: true,
    },
};
