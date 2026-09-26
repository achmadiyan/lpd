-- SI-LPD: kolom laporan kegiatan pada tabel public.lpd
-- Jalankan sekali di Supabase SQL Editor.

alter table public.lpd
  add column if not exists sasaran text,
  add column if not exists proses text,
  add column if not exists alat_bahan text,
  add column if not exists capaian text,
  add column if not exists lintas_program text,
  add column if not exists lintas_sektor text,
  add column if not exists umpan_balik text;

-- Pindahkan data lama dari JSONB fields ke kolom baru.
update public.lpd
set
  sasaran = coalesce(sasaran, fields->>'sasaran'),
  proses = coalesce(proses, fields->>'proses'),
  alat_bahan = coalesce(alat_bahan, fields->>'alatBahan'),
  capaian = coalesce(capaian, fields->>'capaian'),
  lintas_program = coalesce(lintas_program, fields->>'lintasProgram'),
  lintas_sektor = coalesce(lintas_sektor, fields->>'lintasSektor'),
  umpan_balik = coalesce(umpan_balik, fields->>'umpanBalik')
where fields is not null;

create index if not exists idx_lpd_sasaran on public.lpd (sasaran);
create index if not exists idx_lpd_capaian on public.lpd (capaian);
