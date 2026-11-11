defmodule Mix.Tasks.Compile.BinaryPhoenixCrm do
  use Mix.Task.Compiler
  @moduledoc false
  @root __DIR__
  @checksums %{
    "ebin/Elixir.Inspect.PhoenixCRM.Conversation.beam" =>
      "BB3DCC5DCFFFCA6C7AD2351DE89CC5484F31653FE80F091F7B346AB53FDDFA76",
    "ebin/Elixir.Inspect.PhoenixCRM.Message.beam" =>
      "F8E6E2FAC4B619E18097321B877708C706DF86CD7EF2B99D0DD89CFFB0ACC222",
    "ebin/Elixir.PhoenixCRM.Activity.beam" =>
      "4D2DF38AFA4B47196F809BDDA748B30B9C6C6A768BF9FEFA167E8155567532D1",
    "ebin/Elixir.PhoenixCRM.Address.beam" =>
      "7388D19A3E812A9410F7499727C121681390A298D2C5AE6DF91DBC62E4B6789C",
    "ebin/Elixir.PhoenixCRM.AreaRules.beam" =>
      "D3F803FCAF4C87D0A7F807E0D3E08B5E9B433ECF8A46B1173F78E9AECA587BE7",
    "ebin/Elixir.PhoenixCRM.ContactLifecycleMigration.beam" =>
      "DCE38F16A4E0D6DD3E15A45E960266CB35FB9F4390451F54458C103A1C8D73CA",
    "ebin/Elixir.PhoenixCRM.ContactSource.beam" =>
      "F6428976D8196618194A06CAC8BE1838785768D328AC9E9FAF6272206759BA5A",
    "ebin/Elixir.PhoenixCRM.Conversation.beam" =>
      "257BB06E24E076A4D4B5E4750908F8EBC25CEE0181659558C3424C919F9F86E7",
    "ebin/Elixir.PhoenixCRM.ConversationMigration.beam" =>
      "D752A723BB88E0EC197E9A21C9054721CF2C83660D70676DC68A9364734578D5",
    "ebin/Elixir.PhoenixCRM.Conversations.beam" =>
      "D1C3068CA23263216ED008EE41D8F996A52AD610B753EF80EF9C1CB04C6D0AC3",
    "ebin/Elixir.PhoenixCRM.Geography.beam" =>
      "6539D46C76C9F6335E7102809A6577055FD4CEBA0CBC4B47FC14F4E33A614B83",
    "ebin/Elixir.PhoenixCRM.InboundReceiptSchema.beam" =>
      "CB2D50654C3B5143814CD538763BEA46BBC235B1263B7D3338B1D86697EE853F",
    "ebin/Elixir.PhoenixCRM.ListRules.beam" =>
      "60E62C70D8591EAEC264A2ABD70690EB36B7D4D4751469FABC6D31F6C2613461",
    "ebin/Elixir.PhoenixCRM.MailingList.beam" =>
      "A4DA9A5A945D65E2B58AB10101B2B84071D2574AAD09AA0CE8E3031FD6B2AFA1",
    "ebin/Elixir.PhoenixCRM.MailingListEvent.beam" =>
      "9E79F99523BB270F69D3C98A6614CD7AA9C3D4695EE957389273618D4E2E8F05",
    "ebin/Elixir.PhoenixCRM.MailingLists.beam" =>
      "DB9E5870BA2F1DB968BDBADC8D4F2D6AEAF6200AE9CFE98094F4CB6DFFD102A4",
    "ebin/Elixir.PhoenixCRM.MailingListsMigration.beam" =>
      "97FA3A638FCE9CEBA8B295CA97F92F71210C30F31347B216090BD6E055709454",
    "ebin/Elixir.PhoenixCRM.Merge.beam" =>
      "AF7397DC1DED0DB9F71CAECA037FE4934E29F6849E43C07FC463C5534D2966B9",
    "ebin/Elixir.PhoenixCRM.Message.beam" =>
      "AC3F8F2F60DFAA45F691594AD13C24E471934389B7AF6164BB862885D2399F91",
    "ebin/Elixir.PhoenixCRM.Migration.beam" =>
      "C120A08B3A641D432124F2B8D977F5B2B44718F95C276A5AB69000B043400A19",
    "ebin/Elixir.PhoenixCRM.Person.beam" =>
      "5D3D85794694E350D7259FA2D3971AD874BDD6FDE75ABC9583E9EFA25AF7605F",
    "ebin/Elixir.PhoenixCRM.Policy.beam" =>
      "8909651CBF082C1512103D87973157A96C8B538AA42C2B4B4E5351B87AA83905",
    "ebin/Elixir.PhoenixCRM.ReceiptStore.beam" =>
      "6C7493DBE9205A95CC0CA2271E39FD4A4974AF50B5EE29E67C682304E5D33BEC",
    "ebin/Elixir.PhoenixCRM.ReplyNotificationSchema.beam" =>
      "43ABF890F88BC28F0109C0F7416DDBB56847FE88EE7286BD09E4EF3D97395DCF",
    "ebin/Elixir.PhoenixCRM.Source.beam" =>
      "2759F097947D8D68336E9961C02E89F4720997FFD06282928EFD5C365C8AD148",
    "ebin/Elixir.PhoenixCRM.SourceMetadata.beam" =>
      "62E35CEDBE05750DD8FA84B1368D04A74D2C51C6723977299755E26419B6BD16",
    "ebin/Elixir.PhoenixCRM.beam" =>
      "FC31E3B470F45F03C7BE215A4CB6DEE0F2D24C4B92E352C1CE0167ED471015E7",
    "ebin/phoenix_crm.app" => "1D6AC88FE5F041114AAD77A489B81CC959D1B815E74A9F01666E5A886EC31895"
  }

  @impl true
  def run(_args) do
    series = Version.parse!(System.version()) |> Map.take([:major, :minor])

    unless series == %{major: 1, minor: 20} and System.otp_release() == "29" do
      Mix.raise("phoenix_crm requires a binary distribution for Elixir 1.20.x / OTP 29")
    end

    for {path, expected} <- @checksums do
      bytes = File.read!(Path.join(@root, path))

      unless Base.encode16(:crypto.hash(:sha256, bytes)) == expected do
        Mix.raise("phoenix_crm artifact checksum mismatch: #{path}")
      end

      if String.starts_with?(path, "ebin/") do
        target = Path.join(Mix.Project.compile_path(), Path.basename(path))
        File.mkdir_p!(Path.dirname(target))
        File.write!(target, bytes)
      end
    end

    {:ok, []}
  end
end

defmodule Compiled.PhoenixCrm.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_crm,
      version: "0.0.13",
      elixir: "~> 1.20.0",
      compilers: [:binary_phoenix_crm],
      deps: [ecto_sql: "~> 3.13", jason: "~> 1.4"]
    ]
  end

  def application, do: [extra_applications: [:logger]]
end
